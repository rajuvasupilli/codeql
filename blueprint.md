# Visit http://"<TBD>.us.bank-dns.com/sd3 for the detailed yml specification 

sd3-type: blueprint
# Specify the SD3 type with one of 'application', 'component' or 'blueprint'

template-version : 1.1
# Specify template version, this should not be changed by Blueprint owner

cloud-service-provider : AWS
# Specify cloud provider. Ex Azure
 
system-name : Amazon S3
# Specify the name of the system, application or component
 
system-data-classification : Internal
# Specify the data classification with one of 'Public', 'Confidential', 'Internal', 'NoData' or 'Personal' - application data classifications that can consume this blueprint
 
system-owner : papete1 # Paul Petersen
# Specify the intranet ID of the blueprint product owner (who acts as a CEO for the blueprint and manages the product backlog for the blueprint)

engineering-owner : txdonn2 # Tom Donnelly
# Specify the intranet ID of the blueprint engineering owner (Who builds and maintains the code for the blueprint)
 
operational-status: Operational
# Specify operational status with one of 'Operational', 'Under Development', 'Plan'

architecture-type : Infrastructure as a Service (IaaS)
# Specify architecture type with one of software-as-a-service, platform-as-a-service, infrastructure-as-a-service or other

lifecycle-status : Assess
# Specify Lifecycle status of the blueprint with one of 'Assess, Trial, Adopt, Hold'
# Trial: Worth pursuing. It’s important to understand how to build up this capability. Enterprises can use this blueprint that can handle the risk.
# Assess: Worth exploring with the goal of understanding how it will affect your enterprise. Use it in lower environment."
# Adopt: Enterprise should adopt should be adopting these Blueprints. We use them when appropriate in our projects."
# Hold: Proceed with caution & Plan to divest

inheriting-blueprints:
  #- shield-platform                           # all blueprints should have this one
  #- shield-scm                                # all blueprints should have this one
  #- shield-pipeline-iac                       # all IaC blueprints should have this one
  #- usb-aws-foundation                        # all AWS blueprints should have this one

  # Specify list of inheriting/dependent blueprints by tag name. Ex: 'azure-subscription. This is the tag name provided in https://confluenceconsumerbanking.us.bank-dns.com:8443/pages/viewpage.action?pageId=228666213. [label](vscode-file://vscode-app/c%3A/Program%20Files/Microsoft%20VS%20Code/resources/app/out/vs/code/electron-sandbox/workbench/workbench.html)

implementing-controls:
  # Specify list of Control IDs of the controls that are being specifically implemented in this scope. Ideally all controls would come via blueprints.
  - 3005 #CLAWS-82
  - 3052 #CLAWS-115
  - 3053 #CLAWS-116
  - 3115 #CLAWS-160
  # - 3237 #CLAWS-202
  # - 3045 #CLAWS-110

