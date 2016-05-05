#begin
# Update with the name of your subscription.
$SubscriptionName="YourSubscriptionName"

# Give a name to your new storage account. It must be lowercase!
$StorageAccountName="yourstorageaccountname"

# Choose "West US" as an example.
$Location = "West US"

# Give a name to your new container.
$ContainerName = "imagecontainer"

# Have an image file and a source directory in your local computer.
$ImageToUpload = "C:\Images\HelloWorld.png"

# A destination directory in your local computer.
$DestinationFolder = "C:\DownloadImages"

# Add your Azure account to the local PowerShell environment.
Add-AzureAccount

# Set a default Azure subscription.
Select-AzureSubscription -SubscriptionName $SubscriptionName –Default

# Create a new storage account.
New-AzureStorageAccount –StorageAccountName $StorageAccountName -Location $Location

# Set a default storage account.
Set-AzureSubscription -CurrentStorageAccountName $StorageAccountName -SubscriptionName $SubscriptionName

# Create a new container.
New-AzureStorageContainer -Name $ContainerName -Permission Off

# Upload a blob into a container.
Set-AzureStorageBlobContent -Container $ContainerName -File $ImageToUpload

# List all blobs in a container.
Get-AzureStorageBlob -Container $ContainerName

# Download blobs from the container:
# Get a reference to a list of all blobs in a container.
$blobs = Get-AzureStorageBlob -Container $ContainerName

# Create the destination directory.
New-Item -Path $DestinationFolder -ItemType Directory -Force  

# Download blobs into the local destination directory.
$blobs | Get-AzureStorageBlobContent –Destination $DestinationFolder
#end