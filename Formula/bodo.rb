# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1107.4704/bodo-darwin-arm64"
  version "2026.1107.4704"
  sha256 "712dbe4d9786463d9aa34243315cfe85d09890f940f9f217f0d109eb1ad3952c"
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
      url "https://cli.bodo-app.com/v/2026.1107.4704/bodo-linux-arm64"
      sha256 "43dd685948ec72d92171b3d619d64df45b00db03f7323dc7065b3d1fbce89d6d"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1107.4704/bodo-linux-x64"
      sha256 "217ad71cb69f5d5ce2f57215ad5b01b3e53be388ee197ce95cbab65b0dfb0d36"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
