# manifests/munin.pp

class squid::munin {
    munin::plugin{ 'squid_cache': }
    munin::plugin{ 'squid_icp': }
    munin::plugin{ 'squid_requests': }
    munin::plugin{ 'squid_traffic': }
    munin::remoteplugin{ 'squid_efficiency': source => "puppet://$server/squid/munin/squid_efficiency" }
    munin::plugin::deploy{'squid':
        source => "squid/munin/squid",
    }
}
