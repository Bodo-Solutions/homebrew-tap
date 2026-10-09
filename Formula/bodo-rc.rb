# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1009.3779-rc/bodo-darwin-arm64"
  version "2026.1009.3779-rc"
  sha256 "3b5148c19ec892551750c57631c974d132f2398d64f079629caaf58a773b3e0e"
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
      url "https://cli.bodo-app.com/v/2026.1009.3779-rc/bodo-linux-arm64"
      sha256 "e255731108df3bfe391a3398423f126d5ca1a98342d59680231e67bd1d100d49"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1009.3779-rc/bodo-linux-x64"
      sha256 "a25be399d6078a4ed5f465459bf1e30e65f00348f2d66bf4af87625042e70bb0"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
