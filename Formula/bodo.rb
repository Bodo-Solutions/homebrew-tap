# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1025.4421/bodo-darwin-arm64"
  version "2026.1025.4421"
  sha256 "f4a6190daa2a4734203657a023e84fe04c45d983a22add4fa992ab5880ffe0a8"
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
      url "https://cli.bodo-app.com/v/2026.1025.4421/bodo-linux-arm64"
      sha256 "5ebcfa3412dbb5ad9fcffbd332973be06d24637fab264705e637f4335d0498ad"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1025.4421/bodo-linux-x64"
      sha256 "1172e6a1442003ec04a2a08cdebfe25a390e896941679b495bce4e7159c1e690"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
