import { Head, Link, useForm } from '@inertiajs/react';

export default function Login({ status, canResetPassword }) {
    const { data, setData, post, processing, errors, reset } = useForm({
        email: '',
        password: '',
        remember: false,
    });

    const submit = (e) => {
        e.preventDefault();

        post(route('login'), {
            onFinish: () => reset('password'),
        });
    };

    return (
        <>
            <Head title="Log in" />

            <main className="login-wrapper">
                <section className="login-side-panel" aria-hidden="true">
                    <div className="panel-content">
                        <span className="panel-tag">Proyecto Comunitario</span>
                        <h2>Casa Calcuta</h2>
                        <p>
                            Transformando la incertidumbre en control operativo para acompañar mejor a cada familia.
                        </p>
                    </div>
                    <div className="panel-decoration">
                        <div className="circle-1"></div>
                        <div className="circle-2"></div>
                    </div>
                </section>

                <section className="login-form-panel">
                    <div className="form-box">
                        <header className="form-header">
                            <div className="brand-badge">CC</div>
                            <h1>¡Hola! Te damos la bienvenida</h1>
                            <p>Ingresá tus credenciales para acceder al panel de gestión.</p>
                        </header>

                        {status && <div className="alert-success">{status}</div>}

                        <form className="custom-form" onSubmit={submit}>
                            <div className="form-group">
                                <label htmlFor="email">Correo</label>
                                <input
                                    id="email"
                                    type="email"
                                    name="email"
                                    value={data.email}
                                    placeholder="usuario@correo.com"
                                    autoComplete="username"
                                    autoFocus
                                    onChange={(e) => setData('email', e.target.value)}
                                />
                                {errors.email && <div className="field-error">{errors.email}</div>}
                            </div>

                            <div className="form-group">
                                <label htmlFor="password">Contraseña</label>
                                <input
                                    id="password"
                                    type="password"
                                    name="password"
                                    value={data.password}
                                    placeholder="••••••••"
                                    autoComplete="current-password"
                                    onChange={(e) => setData('password', e.target.value)}
                                />
                                {errors.password && <div className="field-error">{errors.password}</div>}
                            </div>

                            <div className="form-row">
                                <label className="remember-group">
                                    <input
                                        type="checkbox"
                                        name="remember"
                                        checked={data.remember}
                                        onChange={(e) => setData('remember', e.target.checked)}
                                    />
                                    Recordarme
                                </label>

                                {canResetPassword && (
                                    <Link href={route('password.request')} className="btn-link">
                                        ¿Olvidaste tu contraseña?
                                    </Link>
                                )}
                            </div>

                            <button type="submit" className="btn-primary" disabled={processing}>
                                Iniciar sesión
                            </button>
                        </form>

                        <footer className="form-footer">
                            <p>Gestión de Proyectos 2026 &bull; UNNOBA</p>
                        </footer>
                    </div>
                </section>
            </main>
        </>
    );
}
