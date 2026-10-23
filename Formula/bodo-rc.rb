# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1023.4291-rc/bodo-darwin-arm64"
  version "2026.1023.4291-rc"
  sha256 "3e189efc436c312b9cce5be8cc8885320fa37ad2ad3c5c462ca2e1c799a111aa"
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
      url "https://cli.bodo-app.com/v/2026.1023.4291-rc/bodo-linux-arm64"
      sha256 "15443936735f940b2a89fa695716fe9ff9950710a7bbc5d1870a3b8f390230ce"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1023.4291-rc/bodo-linux-x64"
      sha256 "41ae4e94c009e643a1a7d8bef154569a88252da3d93ec33c045e5c3bcdf5661d"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
