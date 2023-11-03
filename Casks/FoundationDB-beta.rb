cask "foundationdb-beta" do
  arch arm: "arm64", intel: "x86_64"

  version "7.3.25"
  sha256 arm:   "87a51f4f1aaa30402a899cecd71c8f22a76177e502f6ad485c561ae85d7d5fe7",
         intel: "69795d4d3194c26c0d5a58f59a2bb6b854994ec24845f7f7f90f20232b5e09f3"

  url "https://github.com/apple/foundationdb/releases/download/#{version}/FoundationDB-#{version}_#{arch}.pkg",
      verified: "github.com/apple/foundationdb/"
  name "FoundationDB"
  desc "FoundationDB"
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
