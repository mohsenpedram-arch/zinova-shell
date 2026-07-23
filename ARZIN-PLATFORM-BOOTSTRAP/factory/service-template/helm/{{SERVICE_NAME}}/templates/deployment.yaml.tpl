apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "{{SERVICE_NAME}}.fullname" . }}
  labels:
    app: {{ include "{{SERVICE_NAME}}.name" . }}
    version: "{{ .Values.image.tag }}"
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ include "{{SERVICE_NAME}}.name" . }}
  template:
    metadata:
      labels:
        app: {{ include "{{SERVICE_NAME}}.name" . }}
    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - containerPort: 8080
          env:
            - name: ARZIN_PROFILE
              value: {{ .Values.environment.ARZIN_PROFILE }}
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
