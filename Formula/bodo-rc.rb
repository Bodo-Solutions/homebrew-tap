# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1018.4059-rc/bodo-darwin-arm64"
  version "2026.1018.4059-rc"
  sha256 "8798affbaea39280c02bfaa290be69a008ba12218b341a6dfc0d3d8df6d59f9c"
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
      url "https://cli.bodo-app.com/v/2026.1018.4059-rc/bodo-linux-arm64"
      sha256 "84f6b65b4b9e78e693d379e934d99f382353d584fd2fd232ffa83f465a80461f"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1018.4059-rc/bodo-linux-x64"
      sha256 "5381ad19e7130a6a2648448ccf04676402d75a0b1181595a570e1a78efff9005"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
