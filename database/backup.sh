DB_USER="root"
DB_PASS="Ju32390350!" 
DB_NAME="db_pet_vida"
BACKUP_DIR="../backups"


DATA=$(date +"%Y-%m-%d")
ARQUIVO_FINAL="${BACKUP_DIR}/petvida_${DATA}.sql"


mkdir -p "$BACKUP_DIR"

echo "Iniciando a extração do banco de dados ${DB_NAME}..."


"/c/Program Files/MySQL/MySQL Server 8.0/bin/mysqldump" -u "$DB_USER" -p"$DB_PASS" --routines --triggers --databases "$DB_NAME" > "$ARQUIVO_FINAL"



if [ $? -eq 0 ]; then
    echo "Backup finalizado com sucesso!"
    echo "Salvo em: ${ARQUIVO_FINAL}"
else
    echo "Erro: Falha ao gerar o arquivo de backup." >&2
    exit 1
fi
