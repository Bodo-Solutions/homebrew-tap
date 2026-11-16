# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1116.4742/bodo-darwin-arm64"
  version "2026.1116.4742"
  sha256 "3d47df538109aa17a1f6b71d3331badeb4563b4c3d7387cf1a1dcb6274c3273c"
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
      url "https://cli.bodo-app.com/v/2026.1116.4742/bodo-linux-arm64"
      sha256 "be45ee14af6bcec86725c811a16983f17b204410818f0a02cf4d9a3b34bebcb7"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1116.4742/bodo-linux-x64"
      sha256 "f7d2340abffbc6e15ffc80b27dec0079059d231bdfb5ae7f75d50bf99df415f3"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
