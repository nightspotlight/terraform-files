# cloudflare-dns

## Usage

```hcl
zone_id = "0123zoneid"

a_records = {
  "@" = { address = "123.123.123.123", proxied = true }
}

aaaa_records = {
  "@" = { address = "2345:abcd:ef01:2345::1", proxied = true },
  www = { address = "2345:abcd:ef01:2345::2", proxied = true },
  git = { address = "2345:abcd:ef01:2345::3", proxied = false }
}

cname_records = {
  testcname = { address = "cnametarget.tld", proxied = false }
}

ns_records = {
  "test" = [
    "ns1.example.org",
    "ns2.example.org",
    "ns3.example.net"
  ]
}

txt_records = {
  testtxt1 = "txtvalue1",
  testtxt2 = "txtvalue2"
}
```
