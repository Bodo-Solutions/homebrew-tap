# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1023.4299-rc/bodo-darwin-arm64"
  version "2026.1023.4299-rc"
  sha256 "a67cf68f637a9725bb256b65b0f92903450efb4ca867f95c70f99631d4635a27"
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
      url "https://cli.bodo-app.com/v/2026.1023.4299-rc/bodo-linux-arm64"
      sha256 "320edb9ebd8f5b562acfd8372ab6374db8143238f37d37fa027fd6b5a7431947"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1023.4299-rc/bodo-linux-x64"
      sha256 "10959022c622d793bca5ac7542101ec660e903d1b8bbeab3f8297f76d3c2f6fa"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
