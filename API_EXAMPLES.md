# Exemplos de Requisições da API Pet Vida

## Veterinários

### Listar todos os veterinários
```
GET http://localhost:3000/api/veterinarios
```

### Obter veterinário específico
```
GET http://localhost:3000/api/veterinarios/1
```

## Animais

### Listar todos os animais
```
GET http://localhost:3000/api/animais
```

### Obter animal específico
```
GET http://localhost:3000/api/animais/1
```

## Espécies

### Listar todas as espécies
```
GET http://localhost:3000/api/especies
```

### Obter espécie específica
```
GET http://localhost:3000/api/especies/1
```

## Tutores

### Listar todos os tutores
```
GET http://localhost:3000/api/tutores
```

### Obter tutor específico
```
GET http://localhost:3000/api/tutores/1
```

## Consultas

### Listar agenda de uma data
```
GET http://localhost:3000/api/consultas/agenda/2026-06-29
```

### Obter consulta específica
```
GET http://localhost:3000/api/consultas/1
```

### Agendar nova consulta
```
POST http://localhost:3000/api/consultas
Content-Type: application/json

{
  "animal_id": 1,
  "veterinario_id": 1,
  "data_hora": "2026-06-29T14:30:00",
  "valor": 150.00
}
```

### Concluir consulta
```
PUT http://localhost:3000/api/consultas/1/concluir
Content-Type: application/json

{
  "diagnostico": "Animal em bom estado de saúde"
}
```

## Pagamentos

### Obter pagamento específico
```
GET http://localhost:3000/api/pagamentos/1
```

### Registrar pagamento
```
POST http://localhost:3000/api/pagamentos/1
Content-Type: application/json

{
  "valor_pago": 150.00,
  "forma_pagamento": "pix"
}
```

Formas de pagamento aceitas:
- pix
- cartao
- dinheiro
- convênio

## Relatórios

### Dashboard financeiro
```
GET http://localhost:3000/api/relatorios/dashboard
```

Retorna:
- Total de consultas
- Faturamento total
- Consultas por status
- Pagamentos por forma
- Faturamento mensal

### Relatório de inadimplentes
```
GET http://localhost:3000/api/relatorios/inadimplentes
```

## Exemplos com cURL

### Listar veterinários
```bash
curl http://localhost:3000/api/veterinarios
```

### Agendar consulta
```bash
curl -X POST http://localhost:3000/api/consultas \
  -H "Content-Type: application/json" \
  -d '{
    "animal_id": 1,
    "veterinario_id": 1,
    "data_hora": "2026-06-29T14:30:00",
    "valor": 150.00
  }'
```

### Registrar pagamento
```bash
curl -X POST http://localhost:3000/api/pagamentos/1 \
  -H "Content-Type: application/json" \
  -d '{
    "valor_pago": 150.00,
    "forma_pagamento": "pix"
  }'
```

### Concluir consulta
```bash
curl -X PUT http://localhost:3000/api/consultas/1/concluir \
  -H "Content-Type: application/json" \
  -d '{
    "diagnostico": "Animal em bom estado de saúde"
  }'
```
