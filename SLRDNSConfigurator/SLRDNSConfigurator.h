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

#if __has_feature(modules)
@import Foundation;
#else
#import <Foundation/Foundation.h>
#endif

#if __has_feature(modules)
@import Network;
#else
#import <Network/Network.h>
#endif

NS_ASSUME_NONNULL_BEGIN

/**
 * @enum SLRDoHProvider
 * Defines the available DNS over HTTPS providers.
 */
typedef NS_ENUM(NSUInteger, SLRDoHProvider) {
    /**
     * AdGuard Default DNS
     * @details https://adguard.com/en/adguard-dns/overview.html
     */
    SLRDoHProviderAdGuard = 0,
    /**
     * Cisco Umbrella DNS
     * @details https://support.umbrella.com/hc/articles/360043574271-Using-DNS-over-HTTPS-DoH-with-Umbrella
     */
    SLRDoHProviderCisco,
    /**
     * Canadian Internet Registration Authority Private DNS
     * @details https://www.cira.ca/cybersecurity-services/canadian-shield
     */
    SLRDoHProviderCIRA,
    /**
     * CleanBrowsing Security DNS
     * @details https://cleanbrowsing.org/
     */
    SLRDoHProviderCleanBrowsing,
    /**
     * Cloudflare DNS
     * @details https://developers.cloudflare.com/1.1.1.1/
     */
    SLRDoHProviderCloudflare,
    /**
     * Cloudflare DNS64
     * @details https://developers.cloudflare.com/1.1.1.1/
     */
    SLRDoHProviderCloudflare64,
    /**
     * ControlD Unfiltered DNS
     * @details https://controld.com/
     */
    SLRDoHProviderControlD,
    /**
     * Digitale Gesellschaft DNS
     * @details https://www.digitale-gesellschaft.ch/
     */
    SLRDoHProviderDigitaleGesellschaft,
    /**
     * dnsforge DNS
     * @details https://dnsforge.de/
     */
    SLRDoHProviderDNSForge,
    /**
     * DNSlify DNS
     * @details https://www.dnslify.com/
     */
    SLRDoHProviderDNSlify NS_SWIFT_NAME(dnslify),
    /**
     * Foundation for Applied Privacy DNS
     * @details https://applied-privacy.net/
     */
    SLRDoHProviderFoundationForAppliedPrivacy,
    /**
     * Google DNS
     * @details https://developers.google.com/speed/public-dns/docs/intro
     */
    SLRDoHProviderGoogle,
    /**
     * Google DNS64
     * @details https://developers.google.com/speed/public-dns/docs/intro
     */
    SLRDoHProviderGoogle64,
    /**
     * Hostux Unfiltered DNS
     * @details https://dns.hostux.net/
     */
    SLRDoHProviderHostux,
    /**
     * LibreOps DNS
     * @details https://libredns.gr/
     */
    SLRDoHProviderLibreDNS,
    /**
     * Mozilla Trusted Recursive Resolver DNS (Cloudflare)
     * @details https://wiki.mozilla.org/Security/DOH-resolver-policy
     */
    SLRDoHProviderMozillaCloudflare,
    /**
     * Mozilla Trusted Recursive Resolver DNS (NextDNS)
     * @details https://wiki.mozilla.org/Security/DOH-resolver-policy
     */
    SLRDoHProviderMozillaNextDNS,
    /**
     * Mullvad Unfiltered DNS
     * @details https://mullvad.net/help/dns-over-https-and-dns-over-tls/
     */
    SLRDoHProviderMullvad,
    /**
     * OpenDNS Standard DNS
     * @details https://www.opendns.com/home-internet-security/
     */
    SLRDoHProviderOpenDNS,
    /**
     * Quad9 Secured DNS
     * @details https://www.quad9.net/
     */
    SLRDoHProviderQuad9,
    /**
     * Snopyta DNS
     * @details https://snopyta.org/service/dns/
     */
    SLRDoHProviderSnopyta,
    /**
     * SWITCH DNS
     * @details https://www.switch.ch/security/info/public-dns/
     */
    SLRDoHProviderSWITCH,
    /**
     * Tiarap DNS
     * @details https://doh.tiar.app/
     */
    SLRDoHProviderTiarap,
    /**
     * Usable Privacy DNS
     * @details https://docs.usableprivacy.com/updns/
     */
    SLRDoHProviderUsablePrivacy,
    /**
     * WeVPN DNS
     * @details https://wevpn.com/wedns
     */
    SLRDoHProviderWeDNS,
    /**
     * Xfinity (Comcast) DNS
     * @details https://www.xfinity.com/privacy/policy/dns
     */
    SLRDoHProviderXfinity
} NS_SWIFT_NAME(SLRDNSConfigurator.DoHProvider);

/**
 * @enum SLRDotProvider
 * Defines the available DNS over TLS providers.
 */
typedef NS_ENUM(NSUInteger, SLRDoTProvider) {
    /**
     * AdGuard Default DNS
     * @details https://adguard.com/en/adguard-dns/overview.html
     */
    SLRDoTProviderAdGuard = 0,
    /**
     * Canadian Internet Registration Authority Private DNS
     * @details https://www.cira.ca/cybersecurity-services/canadian-shield
     */
    SLRDoTProviderCIRA,
    /**
     * CleanBrowsing Security DNS
     * @details https://cleanbrowsing.org/
     */
    SLRDoTProviderCleanBrowsing,
    /**
     * Cloudflare DNS
     * @details https://developers.cloudflare.com/1.1.1.1/
     */
    SLRDoTProviderCloudflare,
    /**
     * Cloudflare DNS64
     * @details https://developers.cloudflare.com/1.1.1.1/
     */
    SLRDoTProviderCloudflare64,
    /**
     * ControlD Unfiltered DNS
     * @details https://controld.com/
     */
    SLRDoTProviderControlD,
    /**
     * Digitale Gesellschaft DNS
     * @details https://www.digitale-gesellschaft.ch/
     */
    SLRDoTProviderDigitaleGesellschaft,
    /**
     * dnsforge DNS
     * @details https://dnsforge.de/
     */
    SLRDoTProviderDNSForge,
    /**
     * DNSlify DNS
     * @details https://www.dnslify.com/
     */
    SLRDoTProviderDNSlify NS_SWIFT_NAME(dnslify),
    /**
     * Foundation for Applied Privacy DNS
     * @details https://applied-privacy.net/
     */
    SLRDoTProviderFoundationForAppliedPrivacy,
    /**
     * Google DNS
     * @details https://developers.google.com/speed/public-dns/docs/intro
     */
    SLRDoTProviderGoogle,
    /**
     * Google DNS64
     * @details https://developers.google.com/speed/public-dns/docs/intro
     */
    SLRDoTProviderGoogle64,
    /**
     * Hostux Unfiltered DNS
     * @details https://dns.hostux.net/
     */
    SLRDoTProviderHostux,
    /**
     * LibreOps DNS
     * @details https://libredns.gr/
     */
    SLRDoTProviderLibreDNS,
    /**
     * Mullvad Unfiltered DNS
     * @details https://mullvad.net/help/dns-over-https-and-dns-over-tls/
     */
    SLRDoTProviderMullvad,
    /**
     * Quad9 Secured DNS
     * @details https://www.quad9.net/
     */
    SLRDoTProviderQuad9,
    /**
     * Snopyta DNS
     * @details https://snopyta.org/service/dns/
     */
    SLRDoTProviderSnopyta,
    /**
     * SWITCH DNS
     * @details https://www.switch.ch/security/info/public-dns/
     */
    SLRDoTProviderSWITCH,
    /**
     * Tiarap DNS
     * @details https://doh.tiar.app/
     */
    SLRDoTProviderTiarap,
    /**
     * Usable Privacy DNS
     * @details https://docs.usableprivacy.com/updns/
     */
    SLRDoTProviderUsablePrivacy,
    /**
     * WeVPN DNS
     * @details https://wevpn.com/wedns
     */
    SLRDoTProviderWeDNS,
    /**
     * Xfinity (Comcast) DNS
     * @details https://www.xfinity.com/privacy/policy/dns
     */
    SLRDoTProviderXfinity
} NS_SWIFT_NAME(SLRDNSConfigurator.DoTProvider);

/**
 * @class SLRDNSConfigurator
 * Provides convenience methods to apply secure DNS (DNS over HTTPS or DNS over TLS) to a @c nw_privacy_context.
 */
@interface SLRDNSConfigurator : NSObject

/**
 * Configures the default @c nw_privacy_context with the specified DNS over HTTPS provider.
 * @param provider The DNS over HTTPS provider to use.
 */
+ (void)configureDefaultNetworkContextWithDoHProvider:(SLRDoHProvider)provider;

/**
 * Configures the default @c nw_privacy_context with the specified DNS over TLS provider.
 * @param provider The DNS over TLS provider to use.
 */
+ (void)configureDefaultNetworkContextWithDoTProvider:(SLRDoTProvider)provider;

/**
 * Configures the given @c nw_privacy_context with the specified DNS over HTTPS provider.
 * @param context  The network privacy context to configure.
 * @param provider The DNS over HTTPS provider to use.
 */
+ (void)configureNetworkContext:(nw_privacy_context_t)context withDoHProvider:(SLRDoHProvider)provider;

/**
 * Configures the given @c nw_privacy_context with the specified DNS over TLS provider.
 * @param context  The network privacy context to configure.
 * @param provider The DNS over TLS provider to use.
 */
+ (void)configureNetworkContext:(nw_privacy_context_t)context withDoTProvider:(SLRDoTProvider)provider;

/**
 * Resets the default @c nw_privacy_context to no longer require encrypted domain name resolution.
 */
+ (void)resetDefaultNetworkContext;

/**
 * Resets the given @c nw_privacy_context to no longer require encrypted domain name resolution.
 */
+ (void)resetNetworkContext:(nw_privacy_context_t)context;

@end

NS_ASSUME_NONNULL_END
