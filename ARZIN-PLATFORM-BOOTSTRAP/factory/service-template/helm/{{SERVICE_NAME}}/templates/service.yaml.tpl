apiVersion: v1
kind: Service
metadata:
  name: {{ include "{{SERVICE_NAME}}.fullname" . }}
  labels:
    app: {{ include "{{SERVICE_NAME}}.name" . }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: 8080
  selector:
    app: {{ include "{{SERVICE_NAME}}.name" . }}
