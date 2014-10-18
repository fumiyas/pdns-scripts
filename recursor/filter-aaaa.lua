-- PowerDNS recursor: Filter AAAA records
-- Copyright (c) 2013 SATOH Fumiyasu @ OSS Technology Corp., Japan
--               https://github.com/fumiyas/pdns-scripts
--               https://fumiyas.github.io/
--
-- License GPLv3+: GNU GPL version 3 or later
--
-- PowerDNS recursor 3.4+ is required

function postresolve(remoteip, domain, qtype, records, rcode)
  local rcode_new = rcode
  local records_new = {}

  for i, record in ipairs(records) do
    if record.qtype ~= pdns.AAAA then
      records_new[#records_new + 1] = record
    end
  end

  if #records_new == 0 then
    rcode_new = pdns.NXDOMAIN
  end

  return rcode_new, records_new
end

