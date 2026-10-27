# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1027.4470-rc/bodo-darwin-arm64"
  version "2026.1027.4470-rc"
  sha256 "cb2071dfa54a8064ee2d78877203cf05d090fcd5e06ec941ff3f78251ef88da5"
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
      url "https://cli.bodo-app.com/v/2026.1027.4470-rc/bodo-linux-arm64"
      sha256 "e1e0f3bcc7502911acff1533f8cd302dee9902e493b49a234b36e5b1fc6379f8"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1027.4470-rc/bodo-linux-x64"
      sha256 "7defaa8d083c505932214393636c4a0c00c0bd6153570f5576e87b26ac8200ee"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
