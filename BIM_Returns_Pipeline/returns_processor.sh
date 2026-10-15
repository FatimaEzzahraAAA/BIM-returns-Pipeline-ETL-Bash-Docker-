#!/usr/bin/env bash
set -euo pipefail

TODAY="$(date +%F)"
mkdir -p input output archive errors trash logs
LOG_FILE="logs/returns_$TODAY.log"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

cleanup_tmp() {
  find . -type f -name '*.tmp' | while read -r f; do
    mv "$f" trash/ 2>/dev/null || true
    log "Nettoyage tmp : $f -> trash/"
  done
}

init_report() {
  if [ ! -f output/report.csv ]; then
    echo "id,date,city,reason,count" > output/report.csv
    NEXT_ID=1
  else
    NEXT_ID=$(( $(tail -n +2 output/report.csv | wc -l) + 1 ))
  fi
}

process_file() {
  local file="$1"
  local base city header reason count

  base="$(basename "$file")"     # returns_casa.csv
  city="${base#returns_}"        # casa.csv
  city="${city%.csv}"            # casa

  log "Traitement de $file (ville=$city)"

  header="$(head -n 1 "$file")"

  # 1) Si "reason" est absent, on tente une réparation avec sed
  if ! printf '%s\n' "$header" | grep -q "reason"; then
    log "[$(date +%H:%M)] WARN: missing column 'reason' in $base. Trying repair with sed..."
    sed -i '1s/^\([^,]*,[^,]*,\)[^,]*/\1reason/' "$file"
    header="$(head -n 1 "$file")"
    log "Nouvel en-tête : $header"
  fi

  # 2) Après réparation : on compte, sinon on met de côté
  if printf '%s\n' "$header" | grep -q "reason"; then
    for reason in defective wrong_item changed_mind; do
      count=$(grep -c ",$reason," "$file" || true)
      echo "$NEXT_ID,$TODAY,$city,$reason,$count" >> output/report.csv
      NEXT_ID=$((NEXT_ID+1))
    done

    mv "$file" "archive/${base%.csv}_$TODAY.csv"
    log "[$(date +%H:%M)] INFO: archived as ${base%.csv}_$TODAY.csv"
  else
    mv "$file" "errors/${base%.csv}_$TODAY.csv"
    log "[$(date +%H:%M)] ERROR: missing column 'reason' in $base"
  fi

  log "[$(date +%H:%M)] INFO: job finished"
}

# --- Programme principal ---
init_report
cleanup_tmp

for f in input/*.csv; do
  [ -e "$f" ] || continue
  process_file "$f"
done

log "Fin du traitement returns."