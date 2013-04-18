-- PowerDNS recursor: Filter records
-- Copyright (c) 2013 SATOH Fumiyasu @ OSS Technology Corp., Japan
--               https://GitHub.com/fumiyas/
--               https://twitter.com/satoh_fumiyasu
--
-- License GPLv3+: GNU GPL version 3 or later
--
-- PowerDNS recursor 3.4+ is required

function postresolve(remoteip, domain, qtype, records, rcode)
  local i

  for i = #records, 2, -1 do
    local j = math.random(1, i)
    records[i], records[j] = records[j], records[i]
  end
  setvariable()

  return rcode, records
end

