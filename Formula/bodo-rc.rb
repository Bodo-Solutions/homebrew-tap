# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1006.3677-rc/bodo-darwin-arm64"
  version "2026.1006.3677-rc"
  sha256 "6a4741f456803c26fe9a50bf3d68f131149fe627cbb865a0f736cd304174c091"
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
      url "https://cli.bodo-app.com/v/2026.1006.3677-rc/bodo-linux-arm64"
      sha256 "bd38546692b9746616165966f484a6f7aab6e544d3b58368ec4b1eb9942e0a70"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1006.3677-rc/bodo-linux-x64"
      sha256 "d203afc6d2911fe4d790743d3db635202c8a462993a5adde8564479ab46ee818"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
