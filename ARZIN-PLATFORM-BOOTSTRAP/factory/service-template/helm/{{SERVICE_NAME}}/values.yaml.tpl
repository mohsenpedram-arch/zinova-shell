replicaCount: 1

image:
  repository: arzin/{{SERVICE_NAME}}
  tag: latest
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 8080

resources:
  limits:
    cpu: 500m
    memory: 512Mi
  requests:
    cpu: 250m
    memory: 256Mi

environment:
  ARZIN_PROFILE: "production"

ingress:
  enabled: false
