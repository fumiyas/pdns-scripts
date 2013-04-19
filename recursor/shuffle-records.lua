-- PowerDNS recursor: Shuffle answer records
-- Copyright (c) 2013 SATOH Fumiyasu @ OSS Technology Corp., Japan
--               https://GitHub.com/fumiyas/
--               https://twitter.com/satoh_fumiyasu
--
-- License GPLv3+: GNU GPL version 3 or later
--
-- PowerDNS recursor 3.4+ is required

-- PowerDNS recursor 2.9.13+ shuffles answer records, thus you can
-- get a shuffled records per query if the packet cache is not used.
-- Set 'disable-packetcache = yes' in your recursor.conf or
-- use this script.

function postresolve(remoteip, domain, qtype, records, rcode)
  if #records < 2 then
    -- No multiple records
    return rcode, records
  end

  --[[
  for i = #records, 2, -1 do
    local j = math.random(1, i)
    records[i], records[j] = records[j], records[i]
  end
  --]]

  -- This answer should not be cached in the packet cache
  setvariable()

  return rcode, records
end

