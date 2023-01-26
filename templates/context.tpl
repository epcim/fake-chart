{{- define "context" }}
{{- $_ := (merge . (default dict .Values)) -}}
{{- end }}
