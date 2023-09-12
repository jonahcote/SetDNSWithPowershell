# Define the DNS server addresses
$primaryDNS = "1.1.1.1"
$secondaryDNS = "8.8.8.8"

# Get the list of network adapters
$networkAdapters = Get-NetAdapter

# Loop through the network adapters and select the Ethernet adapter
foreach ($adapter in $networkAdapters) {
    if ($adapter.Name -like "*Ethernet*") {
        # Set the DNS server addresses for the selected adapter
        Set-DnsClientServerAddress -InterfaceAlias $adapter.Name -ServerAddresses ($primaryDNS, $secondaryDNS)
        
        Write-Host "DNS settings updated for $($adapter.Name) with primary DNS $primaryDNS and secondary DNS $secondaryDNS."
        
        # Exit the loop once the non-VPN adapter is found
        break
    }
}
# Loop through the network adapters and select the one that is Wi-Fi
foreach ($adapter in $networkAdapters) {
    if ($adapter.Name -like "*Wi-Fi*") {
        # Set the DNS server addresses for the selected adapter
        Set-DnsClientServerAddress -InterfaceAlias $adapter.Name -ServerAddresses ($primaryDNS, $secondaryDNS)
        
        Write-Host "DNS settings updated for $($adapter.Name) with primary DNS $primaryDNS and secondary DNS $secondaryDNS."
        
        # Exit the loop once the non-VPN adapter is found
        break
    }
}

Write-Host "DNS configuration completed."
