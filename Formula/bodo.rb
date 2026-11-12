# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1112.4724/bodo-darwin-arm64"
  version "2026.1112.4724"
  sha256 "f882ef9f80baa8cf8ea02f7061e0e062b49966dc7c5c374cdcf7b19454993e9a"
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
      url "https://cli.bodo-app.com/v/2026.1112.4724/bodo-linux-arm64"
      sha256 "b8b440773543861e37ecd731f5ccebd81568a0738e80b082d7a6483e1a813775"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1112.4724/bodo-linux-x64"
      sha256 "1b742f84e1fa1b2b6fa00710b89484410070fc5a70b9c6477fc41602b4bb9446"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
