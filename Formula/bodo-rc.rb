# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1019.4080-rc/bodo-darwin-arm64"
  version "2026.1019.4080-rc"
  sha256 "195b7f904d7d0d122438fc3ad10e60dbe5dc802c90a0e233a43b68f634c83191"
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
      url "https://cli.bodo-app.com/v/2026.1019.4080-rc/bodo-linux-arm64"
      sha256 "56cde2be8ac9840ba164cab0d9f4c3630defb2e0546d2a61278f23575df6a5d3"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1019.4080-rc/bodo-linux-x64"
      sha256 "318096a76f4c5201bbd099bf5cd2889275c91a134bbc77b14a5febeb8f6b0363"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
