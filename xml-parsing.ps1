clear
cd ~
#xml parsing
$fileName = '~\Dropbox (Trintech)\Intellicus\reporting_roles_fragment_for_integration.xml'
$xPathExpression = "/root/REPORTING_ROLE/ENTITY_TYPES/ENTITY_TYPE/ENTITY/@ID"
Select-Xml -Path $fileName -XPath  $xPathExpression |  % {"('"+ $_.Node."#text" +"')," } 