-- PowerDNS recursor: Filter the Bash ShellSock (CVE-2014-6271) records
-- Copyright (c) 2014 SATOH Fumiyasu @ OSS Technology Corp., Japan
--               https://github.com/fumiyas/pdns-scripts
--               https://fumiyas.github.io/
--
-- License GPLv3+: GNU GPL version 3 or later
--
-- PowerDNS recursor 3.4+ is required

function postresolve(remoteip, domain, qtype, records, rcode)
  for i, record in ipairs(records) do
    if string.find(record.content, "^\(\) \{") then
      record.content = string.gsub(record.content, "^..", "XX", 1)
    end
  end

  return rcode, records
end

