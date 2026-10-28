# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1028.4512-rc/bodo-darwin-arm64"
  version "2026.1028.4512-rc"
  sha256 "f28da7796c1ba44cd0821d8122bc5bb984b6e105d61f2361ee4ecda7ad2ca1f7"
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
      url "https://cli.bodo-app.com/v/2026.1028.4512-rc/bodo-linux-arm64"
      sha256 "bd94742ec9b5909d3da2445a9ca65b7418bc742dde42dfbdff7eca527db9f2ac"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1028.4512-rc/bodo-linux-x64"
      sha256 "15bdc6b152c5760509e23c69513ac6c9c36cd1efe2ac66437d2cd7e6df463848"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
