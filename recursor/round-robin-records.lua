-- PowerDNS recursor: Round-robin answer records (NOT usable, see below)
-- Copyright (c) 2013 SATOH Fumiyasu @ OSS Technology Corp., Japan
--               https://github.com/fumiyas/pdns-scripts
--               https://fumiyas.github.io/
--
-- License GPLv3+: GNU GPL version 3 or later
--
-- PowerDNS recursor 3.4+ is required

-- PowerDNS recursor 2.9.13+ shuffles answer records, thus you can
-- get a shuffled records per query if the packet cache is not used.
--
-- WARNING: That is why this script is NOT usable!!!!

function postresolve(remoteip, domain, qtype, records, rcode)
  if #records < 2 then
    -- No multiple records
    return rcode, records
  end

  local records_new = {}
  local record_first = records[1]

  for i = #records, 2, -1 do
    records_new[i-1] = records[i]
  end
  records_new[#records] = record_first

  -- This answer should not be cached in the packet cache
  setvariable()

  return rcode, records_new
end

