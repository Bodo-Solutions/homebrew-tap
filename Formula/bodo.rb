# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1120.4755/bodo-darwin-arm64"
  version "2026.1120.4755"
  sha256 "e055cefcfa44a4dccd858e6ead11057f0e4463cff23871f11be630425e21d08a"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1120.4755/bodo-linux-arm64"
      sha256 "09c002fee0e597387a89dbe604fbd3cdbad35710b8b38afe279a6a4a8502a74c"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1120.4755/bodo-linux-x64"
      sha256 "0b7200c24029d0137d2e4157a029c20eb24c142220538c4c9546253d5dcc31b3"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
