{{- define "opal.serverName" -}}
{{- if eq .Release.Name .Chart.Name }}
{{- printf "%s-server" .Release.Name  }}
{{- else }}
{{- printf "%s-%s-server" .Release.Name .Chart.Name }}
{{- end -}}
{{- end -}}

{{- define "opal.clientName" -}}
{{- if eq .Release.Name .Chart.Name }}
{{- printf "%s-client" .Release.Name  }}
{{- else }}
{{- printf "%s-%s-client" .Release.Name .Chart.Name }}
{{- end -}}
{{- end -}}

{{- define "opal.pgsqlName" -}}
{{- if eq .Release.Name .Chart.Name }}
{{- printf "%s-pgsql" .Release.Name  }}
{{- else }}
{{- printf "%s-%s-pgsql" .Release.Name .Chart.Name }}
{{- end -}}
{{- end -}}

{{- define "opal.serverImage" -}}
{{- printf "%s/permitio/opal-server" .Values.image.registry }}:{{  default .Chart.AppVersion .Values.image.tag }}
{{- end -}}

{{- define "opal.clientImage" -}}
{{- printf "%s/permitio/opal-client" (default .Values.image.registry)  }}:{{  default .Chart.AppVersion .Values.image.tag }}
{{- end -}}

{{- define "opal.envSecretsName" -}}
{{- if eq .Release.Name .Chart.Name }}
{{- printf "%s-env-secrets" .Release.Name  }}
{{- else }}
{{- printf "%s-%s-env-secrets" .Release.Name .Chart.Name }}
{{- end -}}
{{- end -}}

{{- define "opal.clientSelectorLabels" -}}
app.kubernetes.io/name: {{ include "opal.clientName" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
opal.ac/role: client
{{- end -}}

{{- define "opal.serverSelectorLabels" -}}
app.kubernetes.io/name: {{ include "opal.serverName" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
opal.ac/role: server
{{- end -}}

{{- define "opal.pgsqlSelectorLabels" -}}
app.kubernetes.io/name: {{ include "opal.pgsqlName" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
opal.ac/role: pgsql
{{- end -}}

{{- define "opal.clientLabels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | quote }}
{{ include "opal.clientSelectorLabels" . }}
{{- end -}}

{{- define "opal.serverLabels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | quote }}
{{ include "opal.serverSelectorLabels" . }}
{{- end -}}

{{- define "opal.pgsqlLabels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | quote }}
{{ include "opal.pgsqlSelectorLabels" . }}
{{- end -}}

