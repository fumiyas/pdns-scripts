-- PowerDNS recursor: Filter AAAA records
-- Copyright (c) 2013 SATOH Fumiyasu @ OSS Technology Corp., Japan
--
-- This program is released under the terms of the GNU Public License v3

function postresolve(remoteip, domain, qtype, records, rcode)
  rcode_new = rcode
  records_new = {}

  for key, record in ipairs(records) do
    if record.qtype ~= pdns.AAAA then
      records_new[key] = record
    end
  end

  if #records_new == 0 then
    rcode = pdns.NXDOMAIN
  end

  return rcode, records_new
end

