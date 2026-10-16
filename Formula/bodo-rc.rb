# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1016.4008-rc/bodo-darwin-arm64"
  version "2026.1016.4008-rc"
  sha256 "27dd268a68b3bcf0b4e16ae6c4674e68617e6cbd7a4e37917b29f02d0721c714"
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
      url "https://cli.bodo-app.com/v/2026.1016.4008-rc/bodo-linux-arm64"
      sha256 "4993e6898051b1d57b28d466dcedaa73862ae774e9230981b5d483291a14725b"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1016.4008-rc/bodo-linux-x64"
      sha256 "0e75504c6c161fcfaadab0332b2eca9b777a25a775403386a6896d0854323abe"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
