# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1121.4761/bodo-darwin-arm64"
  version "2026.1121.4761"
  sha256 "07b60bfc0f0537a5091b840e5aa3f31a538c5c5d5171aac0a6883b69f1867867"
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
      url "https://cli.bodo-app.com/v/2026.1121.4761/bodo-linux-arm64"
      sha256 "d07906b1f254d0ae2d4f8160552f80c10d5dd55b2cb5e39375aff0c492d4021f"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1121.4761/bodo-linux-x64"
      sha256 "c3893b19e2173f42f163e87b8662cc0403732fc6bd73214a882e6f42c7459ac5"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
