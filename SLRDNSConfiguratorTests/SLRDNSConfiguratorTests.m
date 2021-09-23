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

@import XCTest;
@import SLRDNSConfigurator;

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    const char *const host;
    const char *const port;
} SLRDoTConfig;

@interface SLRDNSConfigurator (Testing)

+ (const char *)endpointForDoHProvider:(SLRDoHProvider)provider;
+ (SLRDoTConfig)configurationForDoTProvider:(SLRDoTProvider)provider;
+ (nw_resolver_config_t)createDoHResolverWithEndpoint:(const char *)endpoint;
+ (nw_resolver_config_t)createDoTResolverWithConfiguration:(SLRDoTConfig)configuration;

@end

@interface SLRDNSConfiguratorTests : XCTestCase

@end

@implementation SLRDNSConfiguratorTests

#pragma mark - configureDefaultNetworkContextWithDoHProvider

- (void)testConfigureDefaultNetworkContextWithDoHProvider
{
    XCTAssertNoThrow([SLRDNSConfigurator configureDefaultNetworkContextWithDoHProvider:SLRDoHProviderAdGuard]);
}

#pragma mark - configureDefaultNetworkContextWithDoTProvider

- (void)testConfigureDefaultNetworkContextWithDoTProvider
{
    XCTAssertNoThrow([SLRDNSConfigurator configureDefaultNetworkContextWithDoTProvider:SLRDoTProviderAdGuard]);
}

#pragma mark - configureNetworkContextWithDoHProvider

- (void)testConfigureNetworkContextWithDoHProvider
{
    nw_privacy_context_t testContext = nw_privacy_context_create("testConfigureNetworkContextWithDoHProvider");
    XCTAssertNoThrow([SLRDNSConfigurator configureNetworkContext:testContext withDoHProvider:SLRDoHProviderAdGuard]);
}

#pragma mark - configureNetworkContextWithDoTProvider

- (void)testConfigureNetworkContextWithDoTProvider
{
    nw_privacy_context_t testContext = nw_privacy_context_create("testConfigureNetworkContextWithDoTProvider");
    XCTAssertNoThrow([SLRDNSConfigurator configureNetworkContext:testContext withDoTProvider:SLRDoTProviderAdGuard]);
}

#pragma mark - resetDefaultNetworkContext

- (void)testResetDefaultNetworkContext
{
    XCTAssertNoThrow([SLRDNSConfigurator resetDefaultNetworkContext]);
}

#pragma mark - resetNetworkContext

- (void)testResetNetworkContext
{
    nw_privacy_context_t testContext = nw_privacy_context_create("testResetNetworkContext");
    XCTAssertNoThrow([SLRDNSConfigurator resetNetworkContext:testContext]);
}

#pragma mark - endpointForDoHProvider

- (void)testEndpointForDoHProviderAdGuard
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderAdGuard]);
    XCTAssertEqualObjects(result, @"https://dns.adguard.com/dns-query");
}

- (void)testEndpointForDoHProviderCisco
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderCisco]);
    XCTAssertEqualObjects(result, @"https://doh.umbrella.com/dns-query");
}

- (void)testEndpointForDoHProviderCIRA
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderCIRA]);
    XCTAssertEqualObjects(result, @"https://private.canadianshield.cira.ca/dns-query");
}

- (void)testEndpointForDoHProviderCleanBrowsing
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderCleanBrowsing]);
    XCTAssertEqualObjects(result, @"https://doh.cleanbrowsing.org/doh/security-filter");
}

- (void)testEndpointForDoHProviderCloudflare
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderCloudflare]);
    XCTAssertEqualObjects(result, @"https://cloudflare-dns.com/dns-query");
}

- (void)testEndpointForDoHProviderCloudflare64
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderCloudflare64]);
    XCTAssertEqualObjects(result, @"https://dns64.cloudflare-dns.com/dns-query");
}

- (void)testEndpointForDoHProviderControlD
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderControlD]);
    XCTAssertEqualObjects(result, @"https://freedns.controld.com/p0");
}

- (void)testEndpointForDoHProviderDigitaleGesellschaft
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderDigitaleGesellschaft]);
    XCTAssertEqualObjects(result, @"https://dns.digitale-gesellschaft.ch/dns-query");
}

- (void)testEndpointForDoHProviderDNSForge
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderDNSForge]);
    XCTAssertEqualObjects(result, @"https://dnsforge.de/dns-query");
}

- (void)testEndpointForDoHProviderDNSlify
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderDNSlify]);
    XCTAssertEqualObjects(result, @"https://doh.dnslify.com/dns-query");
}

- (void)testEndpointForDoHProviderFoundationForAppliedPrivacy
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderFoundationForAppliedPrivacy]);
    XCTAssertEqualObjects(result, @"https://doh.applied-privacy.net/query");
}

- (void)testEndpointForDoHProviderGoogle
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderGoogle]);
    XCTAssertEqualObjects(result, @"https://dns.google/dns-query");
}

- (void)testEndpointForDoHProviderGoogle64
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderGoogle64]);
    XCTAssertEqualObjects(result, @"https://dns64.dns.google/dns-query");
}

- (void)testEndpointForDoHProviderHostux
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderHostux]);
    XCTAssertEqualObjects(result, @"https://dns.hostux.net/dns-query");
}

- (void)testEndpointForDoHProviderLibreDNS
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderLibreDNS]);
    XCTAssertEqualObjects(result, @"https://doh.libredns.gr/dns-query");
}

- (void)testEndpointForDoHProviderMozillaCloudflare
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderMozillaCloudflare]);
    XCTAssertEqualObjects(result, @"https://mozilla.cloudflare-dns.com/dns-query");
}

- (void)testEndpointForDoHProviderMozillaNextDNS
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderMozillaNextDNS]);
    XCTAssertEqualObjects(result, @"https://firefox.dns.nextdns.io");
}

- (void)testEndpointForDoHProviderMullvad
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderMullvad]);
    XCTAssertEqualObjects(result, @"https://doh.mullvad.net/dns-query");
}

- (void)testEndpointForDoHProviderOpenDNS
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderOpenDNS]);
    XCTAssertEqualObjects(result, @"https://doh.opendns.com/dns-query");
}

- (void)testEndpointForDoHProviderQuad9
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderQuad9]);
    XCTAssertEqualObjects(result, @"https://dns11.quad9.net/dns-query");
}

- (void)testEndpointForDoHProviderSnopyta
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderSnopyta]);
    XCTAssertEqualObjects(result, @"https://fi.doh.dns.snopyta.org/dns-query");
}

- (void)testEndpointForDoHProviderSWITCH
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderSWITCH]);
    XCTAssertEqualObjects(result, @"https://dns.switch.ch/dns-query");
}

- (void)testEndpointForDoHProviderTiarap
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderTiarap]);
    XCTAssertEqualObjects(result, @"https://doh.tiar.app/dns-query");
}

- (void)testEndpointForDoHProviderUsablePrivacy
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderUsablePrivacy]);
    XCTAssertEqualObjects(result, @"https://adfree.usableprivacy.net/query-dns");
}

- (void)testEndpointForDoHProviderWeDNS
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderWeDNS]);
    XCTAssertEqualObjects(result, @"https://dns.wevpn.com/dns-query");
}

- (void)testEndpointForDoHProviderXfinity
{
    NSString *result = @([SLRDNSConfigurator endpointForDoHProvider:SLRDoHProviderXfinity]);
    XCTAssertEqualObjects(result, @"https://doh.xfinity.com/dns-query");
}

#pragma mark - configurationForDoTProvider

- (void)testConfigurationForDoTProviderAdGuard
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderAdGuard];
    XCTAssertEqualObjects(@(result.host), @"dns.adguard.com");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderCIRA
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderCIRA];
    XCTAssertEqualObjects(@(result.host), @"private.canadianshield.cira.ca");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderCleanBrowsing
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderCleanBrowsing];
    XCTAssertEqualObjects(@(result.host), @"security-filter-dns.cleanbrowsing.org");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderCloudflare
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderCloudflare];
    XCTAssertEqualObjects(@(result.host), @"cloudflare-dns.com");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderCloudflare64
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderCloudflare64];
    XCTAssertEqualObjects(@(result.host), @"dns64.cloudflare-dns.com");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderControlD
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderControlD];
    XCTAssertEqualObjects(@(result.host), @"p0.freedns.controld.com");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderDigitaleGesellschaft
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderDigitaleGesellschaft];
    XCTAssertEqualObjects(@(result.host), @"dns.digitale-gesellschaft.ch");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderDNSForge
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderDNSForge];
    XCTAssertEqualObjects(@(result.host), @"dnsforge.de");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderDNSlify
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderDNSlify];
    XCTAssertEqualObjects(@(result.host), @"dot.dnslify.com");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderFoundationForAppliedPrivacy
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderFoundationForAppliedPrivacy];
    XCTAssertEqualObjects(@(result.host), @"dot1.applied-privacy.net");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderGoogle
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderGoogle];
    XCTAssertEqualObjects(@(result.host), @"dns.google");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderGoogle64
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderGoogle64];
    XCTAssertEqualObjects(@(result.host), @"dns64.dns.google");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderHostux
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderHostux];
    XCTAssertEqualObjects(@(result.host), @"dns.hostux.net");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderLibreDNS
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderLibreDNS];
    XCTAssertEqualObjects(@(result.host), @"dot.libredns.gr");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderMullvad
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderMullvad];
    XCTAssertEqualObjects(@(result.host), @"dot.mullvad.net");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderQuad9
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderQuad9];
    XCTAssertEqualObjects(@(result.host), @"dns11.quad9.net");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderSnopyta
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderSnopyta];
    XCTAssertEqualObjects(@(result.host), @"fi.dot.dns.snopyta.org");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderSWITCH
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderSWITCH];
    XCTAssertEqualObjects(@(result.host), @"dns.switch.ch");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderTiarap
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderTiarap];
    XCTAssertEqualObjects(@(result.host), @"dot.tiar.app");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderUsablePrivacy
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderUsablePrivacy];
    XCTAssertEqualObjects(@(result.host), @"adfree.usableprivacy.net");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderWeDNS
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderWeDNS];
    XCTAssertEqualObjects(@(result.host), @"dns.wevpn.com");
    XCTAssertEqualObjects(@(result.port), @"853");
}

- (void)testConfigurationForDoTProviderXfinity
{
    SLRDoTConfig result = [SLRDNSConfigurator configurationForDoTProvider:SLRDoTProviderXfinity];
    XCTAssertEqualObjects(@(result.host), @"dot.xfinity.com");
    XCTAssertEqualObjects(@(result.port), @"853");
}

#pragma mark - createDoHResolverWithEndpoint

- (void)testCreateDoHResolverWithEndpoint
{
    nw_resolver_config_t result = [SLRDNSConfigurator createDoHResolverWithEndpoint:"https://www.example.com/dns-query"];
    XCTAssertNotNil(result);
}

#pragma mark - createDoTResolverWithConfiguration

- (void)testCreateDoTResolverWithConfiguration
{
    SLRDoTConfig config = { "example.com", "853" };
    nw_resolver_config_t result = [SLRDNSConfigurator createDoTResolverWithConfiguration:config];
    XCTAssertNotNil(result);
}

@end

NS_ASSUME_NONNULL_END
