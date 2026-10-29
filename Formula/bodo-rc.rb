# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1029.4574-rc/bodo-darwin-arm64"
  version "2026.1029.4574-rc"
  sha256 "c1d066144bc6af1d98d8c09a7bbe6bd9a848c531da28b941fc509a0a2e978394"
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
      url "https://cli.bodo-app.com/v/2026.1029.4574-rc/bodo-linux-arm64"
      sha256 "42358a0dd558f7286617a0119545d1836de1f9b392a15e120c172e9385755b70"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1029.4574-rc/bodo-linux-x64"
      sha256 "26e87508ee0618a09e955167395d813695f542b79dc2e4a7a6a7c141c8d82176"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
