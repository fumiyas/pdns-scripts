-- PowerDNS recursor: Filter AAAA records
-- Copyright (c) 2013 SATOH Fumiyasu @ OSS Technology Corp., Japan
--               https://github.com/fumiyas/pdns-scripts
--               https://fumiyas.github.io/
--
-- License GPLv3+: GNU GPL version 3 or later
--
-- PowerDNS recursor 3.4+ is required

function postresolve(remoteip, domain, qtype, records, rcode)
  local records_new = {}

  for i, record in ipairs(records) do
    if record.qtype ~= pdns.AAAA then
      records_new[#records_new + 1] = record
    end
  end

  return rcode, records_new
end

