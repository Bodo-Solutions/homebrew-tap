# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1019.4073-rc/bodo-darwin-arm64"
  version "2026.1019.4073-rc"
  sha256 "f3a6410dc3d3358842b14a7a2868c0de378d7a2689d98539202383c47d08767e"
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
      url "https://cli.bodo-app.com/v/2026.1019.4073-rc/bodo-linux-arm64"
      sha256 "9b40b34fa89ec8a6e81f5aaddd8d65719f80172926c0cde20aca618ec2c313b3"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1019.4073-rc/bodo-linux-x64"
      sha256 "815d4e349e0f820269a3973c95eac69174b3ad41b96d5fed20e8db163c28c346"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
