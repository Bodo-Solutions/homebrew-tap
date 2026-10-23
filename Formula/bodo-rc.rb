# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1023.4312-rc/bodo-darwin-arm64"
  version "2026.1023.4312-rc"
  sha256 "9a95b017ef9dacde15ff88d96959e42e32c70e1b47430e48a4e5dcff238034f2"
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
      url "https://cli.bodo-app.com/v/2026.1023.4312-rc/bodo-linux-arm64"
      sha256 "35ca5c4fa9bd08c907696bfec03180f2823aff44e58525ea72f2fa0a8f777354"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1023.4312-rc/bodo-linux-x64"
      sha256 "9149b2d009b93fd99a15fea95be1c3d380151e2161c6b14c5706e40ff99f3769"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
