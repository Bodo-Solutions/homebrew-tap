# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1128.4771/bodo-darwin-arm64"
  version "2026.1128.4771"
  sha256 "ef3e978191fabdbc17c21cd2274e6fa6c69cf9c08031541ba258fe1aa880949e"
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
      url "https://cli.bodo-app.com/v/2026.1128.4771/bodo-linux-arm64"
      sha256 "dac0d76e63a641f588cd92edceaba8f95033d29e577837c4dc4774f9c42088b1"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1128.4771/bodo-linux-x64"
      sha256 "ff51162db9da9100bc139d34009efa31fbd065a6cb0907657fa348ec4abe7b03"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
