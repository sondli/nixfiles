#!/usr/bin/env zsh

response=$(az rest --method get --url "https://app-planner3-prod.azurewebsites.net/healthz" -o json 2>/dev/null)

if [[ $? -ne 0 ]] || [[ -z "$response" ]]; then
    echo '{"text":"Planner: Error","class":"error","tooltip":"Failed to reach health endpoint"}'
    exit 0
fi

health=$(echo "$response" | jq -r '.status')
db=$(echo "$response" | jq -r '.entries.database.status')
identity=$(echo "$response" | jq -r '.entries["trimble-identity"].status')

if [[ "$health" == "Healthy" ]]; then
    class="healthy"
else
    class="unhealthy"
fi

tooltip="DB: $db | Identity: $identity"

echo "{\"text\":\"Planner: $health\",\"class\":\"$class\",\"tooltip\":\"$tooltip\"}"
