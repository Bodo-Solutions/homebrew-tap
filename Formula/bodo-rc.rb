# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1027.4486-rc/bodo-darwin-arm64"
  version "2026.1027.4486-rc"
  sha256 "217b8cf0bae4ae52c57ca5aab0275bf96d3ed82041ae62054fde7bc253d15b5e"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/rc/manifest.json"
    regex(/^v?(\d+(?:\.\d+)+(?:-rc)?)$/i)
    strategy :json do |json, regex|
      json["version"]&.[](regex, 1)
    end
  end

  on_macos do
    depends_on arch: :arm64 unless Hardware::CPU.in_rosetta2?
  end

  on_linux do
    on_arm do
      url "https://cli.bodo-app.com/v/2026.1027.4486-rc/bodo-linux-arm64"
      sha256 "34864b74c98aca6a3bd2d5884ff0d7a4cabdbd5ffabfa9c921d8f3fc82a8954f"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1027.4486-rc/bodo-linux-x64"
      sha256 "cfba98a91d4bbb875c8f6a021eef3e136832a7ccf60fcd9d11d1cb15efb87d2e"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
