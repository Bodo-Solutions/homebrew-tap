# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4344-rc/bodo-darwin-arm64"
  version "2026.1024.4344-rc"
  sha256 "bbbe0935b3530db1f5761b46addb0db0c404b7d14bb02b3b2c4aa44542e56fa9"
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
      url "https://cli.bodo-app.com/v/2026.1024.4344-rc/bodo-linux-arm64"
      sha256 "8eb17609f6210a4ebdd7c8731d8a8cff3e149628dc15ced974a908e1d80b156d"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4344-rc/bodo-linux-x64"
      sha256 "3f5d48e745add17a5cef6f38bf0af1016817c1e3501a196fcbdc3013cafb0182"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
