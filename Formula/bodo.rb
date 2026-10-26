# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1026.4461/bodo-darwin-arm64"
  version "2026.1026.4461"
  sha256 "3478c75fbb753f9c740cd6e2b7298211a4ea194fa0cebe32662fa15f2208c752"
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
      url "https://cli.bodo-app.com/v/2026.1026.4461/bodo-linux-arm64"
      sha256 "e39bace9688b76b6022ef514d337cdb346445d052198b221d870fe6a0e05ffcf"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1026.4461/bodo-linux-x64"
      sha256 "e6c825e16fbb1662fd29dc59207ff57489745f9de2a94b67eb1e872a5dfd3d0a"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
