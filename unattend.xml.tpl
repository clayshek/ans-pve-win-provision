<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
  <settings pass="generalize">
    <component name="Microsoft-Windows-PnpSysprep" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <PersistAllDeviceInstalls>true</PersistAllDeviceInstalls>
    </component>
  </settings>
  <settings pass="specialize">
    <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <ComputerName>{{vm_name}}</ComputerName>
      <TimeZone>{{vm_time_zone}}</TimeZone>
    </component>
    <component name="Microsoft-Windows-TCPIP" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <Interfaces>
          <Interface wcm:action="add">
            <Ipv4Settings>
                <DhcpEnabled>false</DhcpEnabled>
                <RouterDiscoveryEnabled>true</RouterDiscoveryEnabled>
            </Ipv4Settings>
            <Ipv6Settings>
                <DhcpEnabled>false</DhcpEnabled>
                <RouterDiscoveryEnabled>true</RouterDiscoveryEnabled>
            </Ipv6Settings>
            <Identifier>Ethernet</Identifier>
            <UnicastIpAddresses>
                <IpAddress wcm:action="add" wcm:keyValue="1">{{vm_static_ip_and_mask}}</IpAddress>
                </UnicastIpAddresses>
            <Routes>
                <Route wcm:action="add">
                  <Identifier>1</Identifier>
                  <NextHopAddress>{{vm_default_gateway}}</NextHopAddress>
                  <Prefix>0.0.0.0/0</Prefix>
                </Route>
            </Routes>
          </Interface>
      </Interfaces>
    </component>
    <component name="Microsoft-Windows-DNS-Client" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <Interfaces>
          <Interface wcm:action="add">
              <DNSServerSearchOrder>
                  <IpAddress wcm:action="add" wcm:keyValue="1">{{vm_dns_server}}</IpAddress>
              </DNSServerSearchOrder>
              <Identifier>Ethernet</Identifier>
          </Interface>
      </Interfaces>
    </component>         
  </settings>
  <settings pass="oobeSystem">
    <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State">
      <UserAccounts>
        <AdministratorPassword>
          <Value>{{vm_admin_pass}}</Value>
          <PlainText>true</PlainText>
        </AdministratorPassword>
      </UserAccounts>
      <OOBE>
        <HideEULAPage>true</HideEULAPage>
        <NetworkLocation>Work</NetworkLocation>
        <ProtectYourPC>1</ProtectYourPC>
        <SkipMachineOOBE>true</SkipMachineOOBE>
        <SkipUserOOBE>true</SkipUserOOBE>
      </OOBE>
    </component>
  </settings>  
</unattend>