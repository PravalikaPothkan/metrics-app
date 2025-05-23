# Deploying metrics-app
1. Helm chart creation to deploy metrics-app into the kubernetes cluster.

2. Setup kubernetes cluster
'''
brew install kind
kind version
kind create cluster --name kind-cluster
kubectl config get-contexts
kubectl config use-context kind-kind-cluster
kubectl config current-context
'''

3. Installing argocd in the cluster. 
'''
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl port-forward svc/argocd-server -n argocd 8080:443
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
'''

Access the ArgoCD UI at https://localhost:8080 and log in with:
Username: admin
Password: qCt18kSpjIhdSg4P 

argocd login localhost:8080 --username admin --password h9b-TrxjvxiUR41D --insecure


4. Configure ArgoCD to Watch Your Git Repository
Push Your Helm Chart to a Git Repository:

Ensure your Helm chart is in a Git repository (e.g., GitHub).
The repository should be public or accessible with credentials.
Create an ArgoCD Application: Save the following YAML as argocd-application.yaml:
'''
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: metrics-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: 'https://github.com/<your-username>/<your-repo>'
    targetRevision: HEAD
    path: metrics-app
  destination:
    server: https://kubernetes.default.svc
    namespace: default
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
'''



