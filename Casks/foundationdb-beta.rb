cask "foundationdb-beta" do
  arch arm: "arm64", intel: "x86_64"

  version "7.3.27"
  sha256 arm:   "585103123cb8adb0f2813c47c1b12ec6757924b4a8880f00b1cd03d1ed2556fd",
         intel: "57287c3deab1824f7f1bbc3728a4538d171da9d5a363975813bef07a8cf15653"

  url "https://github.com/apple/foundationdb/releases/download/#{version}/FoundationDB-#{version}_#{arch}.pkg",
      verified: "github.com/apple/foundationdb/"
  name "FoundationDB"
  desc "Distributed database"
  homepage "https://www.foundationdb.org/"

  livecheck do
    url :url
    regex(/^(\d+(?:\.\d+)+)$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"] || !release["prerelease"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  conflicts_with cask: "foundationdb"

  pkg "FoundationDB-#{version}_#{arch}.pkg"

  uninstall pkgutil: [
    "FoundationDB-server",
    "FoundationDB-clients",
  ]

  zap rmdir: [
    "/usr/local/etc/foundationdb",
    "/usr/local/foundationdb",
  ]
end
