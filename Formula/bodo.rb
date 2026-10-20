# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1020.4123/bodo-darwin-arm64"
  version "2026.1020.4123"
  sha256 "52876ebd0836909524225bedf305430f9bdb756fb3f9667c026ef21dc3b4d8f0"
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
      url "https://cli.bodo-app.com/v/2026.1020.4123/bodo-linux-arm64"
      sha256 "2231affb29fe002c0b64dc84fbef34f8b78f7756ca1fd0b713833e10d47aee03"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1020.4123/bodo-linux-x64"
      sha256 "f60e5bcbc45b6c4052da3a9aca5247aeaae9c20b66e981529b8767940871621d"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
