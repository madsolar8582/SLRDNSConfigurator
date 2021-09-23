/**
 * Copyright (©) 2021 Madison Solarana
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

#import "SLRDNSConfigurator.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * @struct SLRDotConfig
 * Configuration object containing the necessary pieces of DNS over TLS information.
 */
typedef struct {
    const char *const host;
    const char *const port;
} SLRDoTConfig;

/**
 * The default port used for servers running DNS over TLS.
 */
static const char *const SLRDefaultDoTPort = "853";

@implementation SLRDNSConfigurator

#pragma mark - Public API

+ (void)configureDefaultNetworkContextWithDoHProvider:(SLRDoHProvider)provider
{
    [SLRDNSConfigurator configureNetworkContext:NW_DEFAULT_PRIVACY_CONTEXT withDoHProvider:provider];
}

+ (void)configureDefaultNetworkContextWithDoTProvider:(SLRDoTProvider)provider
{
    [SLRDNSConfigurator configureNetworkContext:NW_DEFAULT_PRIVACY_CONTEXT withDoTProvider:provider];
}

+ (void)configureNetworkContext:(nw_privacy_context_t)context withDoHProvider:(SLRDoHProvider)provider
{
    NSParameterAssert(context != nil);
    const char *endpoint = [SLRDNSConfigurator endpointForDoHProvider:provider];
    nw_resolver_config_t dohResolver = [SLRDNSConfigurator createDoHResolverWithEndpoint:endpoint];
    nw_privacy_context_require_encrypted_name_resolution(context, true, dohResolver);
}

+ (void)configureNetworkContext:(nw_privacy_context_t)context withDoTProvider:(SLRDoTProvider)provider
{
    NSParameterAssert(context != nil);
    SLRDoTConfig config = [SLRDNSConfigurator configurationForDoTProvider:provider];
    nw_resolver_config_t dotResolver = [SLRDNSConfigurator createDoTResolverWithConfiguration:config];
    nw_privacy_context_require_encrypted_name_resolution(context, true, dotResolver);
}

+ (void)resetDefaultNetworkContext
{
    [SLRDNSConfigurator resetNetworkContext:NW_DEFAULT_PRIVACY_CONTEXT];
}

+ (void)resetNetworkContext:(nw_privacy_context_t)context
{
    nw_privacy_context_require_encrypted_name_resolution(context, false, NULL);
}

#pragma mark - Private API

/**
 * Determines the DNS over HTTPS endpoint for the given DoH provider.
 * @param provider The DNS over HTTPS provider to lookup.
 * @return The DNS over HTTPS endpoint for the given DoH provider.
 */
+ (const char *)endpointForDoHProvider:(SLRDoHProvider)provider
{
    const char *endpoint = "";
    
    switch (provider) {
        case SLRDoHProviderAdGuard:
            endpoint = "https://dns.adguard.com/dns-query";
            break;
        case SLRDoHProviderCisco:
            endpoint = "https://doh.umbrella.com/dns-query";
            break;
        case SLRDoHProviderCIRA:
            endpoint = "https://private.canadianshield.cira.ca/dns-query";
            break;
        case SLRDoHProviderCleanBrowsing:
            endpoint = "https://doh.cleanbrowsing.org/doh/security-filter";
            break;
        case SLRDoHProviderCloudflare:
            endpoint = "https://cloudflare-dns.com/dns-query";
            break;
        case SLRDoHProviderCloudflare64:
            endpoint = "https://dns64.cloudflare-dns.com/dns-query";
            break;
        case SLRDoHProviderControlD:
            endpoint = "https://freedns.controld.com/p0";
            break;
        case SLRDoHProviderDigitaleGesellschaft:
            endpoint = "https://dns.digitale-gesellschaft.ch/dns-query";
            break;
        case SLRDoHProviderDNSForge:
            endpoint = "https://dnsforge.de/dns-query";
            break;
        case SLRDoHProviderDNSlify:
            endpoint = "https://doh.dnslify.com/dns-query";
            break;
        case SLRDoHProviderFoundationForAppliedPrivacy:
            endpoint = "https://doh.applied-privacy.net/query";
            break;
        case SLRDoHProviderGoogle:
            endpoint = "https://dns.google/dns-query";
            break;
        case SLRDoHProviderGoogle64:
            endpoint = "https://dns64.dns.google/dns-query";
            break;
        case SLRDoHProviderHostux:
            endpoint = "https://dns.hostux.net/dns-query";
            break;
        case SLRDoHProviderLibreDNS:
            endpoint = "https://doh.libredns.gr/dns-query";
            break;
        case SLRDoHProviderMozillaCloudflare:
            endpoint = "https://mozilla.cloudflare-dns.com/dns-query";
            break;
        case SLRDoHProviderMozillaNextDNS:
            endpoint = "https://firefox.dns.nextdns.io";
            break;
        case SLRDoHProviderMullvad:
            endpoint = "https://doh.mullvad.net/dns-query";
            break;
        case SLRDoHProviderOpenDNS:
            endpoint = "https://doh.opendns.com/dns-query";
            break;
        case SLRDoHProviderQuad9:
            endpoint = "https://dns11.quad9.net/dns-query";
            break;
        case SLRDoHProviderSnopyta:
            endpoint = "https://fi.doh.dns.snopyta.org/dns-query";
            break;
        case SLRDoHProviderSWITCH:
            endpoint = "https://dns.switch.ch/dns-query";
            break;
        case SLRDoHProviderTiarap:
            endpoint = "https://doh.tiar.app/dns-query";
            break;
        case SLRDoHProviderUsablePrivacy:
            endpoint = "https://adfree.usableprivacy.net/query-dns";
            break;
        case SLRDoHProviderWeDNS:
            endpoint = "https://dns.wevpn.com/dns-query";
            break;
        case SLRDoHProviderXfinity:
            endpoint = "https://doh.xfinity.com/dns-query";
            break;
    }
    
    return endpoint;
}

/**
 * Determines the DNS over TLS configuration for the given DoT provider.
 * @param provider The DNS over TLS provider to lookup.
 * @return The DNS over TLS configuration for the given DoT provider.
 */
+ (SLRDoTConfig)configurationForDoTProvider:(SLRDoTProvider)provider
{
    const char *host = "";
    const char *port = SLRDefaultDoTPort; // Customize port per provider only if an alternative port is used, e.g. 8853
    
    switch (provider) {
        case SLRDoTProviderAdGuard:
            host = "dns.adguard.com";
            break;
        case SLRDoTProviderCIRA:
            host = "private.canadianshield.cira.ca";
            break;
        case SLRDoTProviderCleanBrowsing:
            host = "security-filter-dns.cleanbrowsing.org";
            break;
        case SLRDoTProviderCloudflare:
            host = "cloudflare-dns.com";
            break;
        case SLRDoTProviderCloudflare64:
            host = "dns64.cloudflare-dns.com";
            break;
        case SLRDoTProviderControlD:
            host = "p0.freedns.controld.com";
            break;
        case SLRDoTProviderDigitaleGesellschaft:
            host = "dns.digitale-gesellschaft.ch";
            break;
        case SLRDoTProviderDNSForge:
            host = "dnsforge.de";
            break;
        case SLRDoTProviderDNSlify:
            host = "dot.dnslify.com";
            break;
        case SLRDoTProviderFoundationForAppliedPrivacy:
            host = "dot1.applied-privacy.net";
            break;
        case SLRDoTProviderGoogle:
            host = "dns.google";
            break;
        case SLRDoTProviderGoogle64:
            host = "dns64.dns.google";
            break;
        case SLRDoTProviderHostux:
            host = "dns.hostux.net";
            break;
        case SLRDoTProviderLibreDNS:
            host = "dot.libredns.gr";
            break;
        case SLRDoTProviderMullvad:
            host = "dot.mullvad.net";
            break;
        case SLRDoTProviderQuad9:
            host = "dns11.quad9.net";
            break;
        case SLRDoTProviderSnopyta:
            host = "fi.dot.dns.snopyta.org";
            break;
        case SLRDoTProviderSWITCH:
            host = "dns.switch.ch";
            break;
        case SLRDoTProviderTiarap:
            host = "dot.tiar.app";
            break;
        case SLRDoTProviderUsablePrivacy:
            host = "adfree.usableprivacy.net";
            break;
        case SLRDoTProviderWeDNS:
            host = "dns.wevpn.com";
            break;
        case SLRDoTProviderXfinity:
            host = "dot.xfinity.com";
            break;
    }
    
    SLRDoTConfig config = { host, port };
    return config;
}

/**
 * Creates a @c nw_resolver_config for DNS over HTTPS.
 * @param endpoint The DNS over HTTPS endpoint to use.
 * @return A DNS over HTTPS resolver configuration.
 */
+ (nw_resolver_config_t)createDoHResolverWithEndpoint:(const char *)endpoint
{
    nw_endpoint_t dohEndpoint = nw_endpoint_create_url(endpoint);
    nw_resolver_config_t dohResolver = nw_resolver_config_create_https(dohEndpoint);
    return dohResolver;
}

/**
 * Creates a @c nw_resolver_config for DNS over TLS.
 * @param configuration The DNS over TLS configuration to use.
 * @return A DNS over TLS resolver configuration.
 */
+ (nw_resolver_config_t)createDoTResolverWithConfiguration:(SLRDoTConfig)configuration
{
    nw_endpoint_t dotEndpoint = nw_endpoint_create_host(configuration.host, configuration.port);
    nw_resolver_config_t dotResolver = nw_resolver_config_create_tls(dotEndpoint);
    return dotResolver;
}

@end

NS_ASSUME_NONNULL_END
