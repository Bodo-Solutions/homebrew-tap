# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1018.4042-rc/bodo-darwin-arm64"
  version "2026.1018.4042-rc"
  sha256 "1a169439c619d45cb56cb5d52fd230d96e189fadc8ece98a08e71646cd23b876"
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
      url "https://cli.bodo-app.com/v/2026.1018.4042-rc/bodo-linux-arm64"
      sha256 "205d497b2d2fd4314c064a3418601134833e7fb8240b3f9b7a254a8bea18b2d4"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1018.4042-rc/bodo-linux-x64"
      sha256 "2f1c7b10bb66afe7a12ba1d8616a5dd9402729da7379b15304399d3a8940629e"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
