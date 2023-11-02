cask "foundationdb" do
  name "FoundationDB"
  desc "FoundationDB"
  homepage "https://www.foundationdb.org"

  arch arm: "arm64", intel: "x86_64"

  version "7.1.43"
  sha256 arm: "685c1087dcf5d552e59a8c24764c535e9281c1e4501e06c2a0103b8ea2c39b2b",
         intel: "7c7e1784a84690cdecb629ba99f5232da1eaf29c473751178600c16b8b88e3dd"

  url "https://github.com/apple/foundationdb/releases/download/#{version}/FoundationDB-#{version}_#{arch}.pkg",
    verified: "github.com/apple/foundationdb/"
  livecheck do
    url :url
    strategy :github_latest
  end

  pkg "FoundationDB-#{version}_#{arch}.pkg"
  uninstall pkgutil: [
    "FoundationDB-server",
    "FoundationDB-clients",
  ]
end
